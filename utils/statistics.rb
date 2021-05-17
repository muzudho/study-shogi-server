#!/usr/bin/ruby
# This program shows statistics of CSA kifu files like following: 
#   - Monthly #games and #players
#   - Game results
#   - Time of each move
#   - Time of each game
#   - Moves of each game
#
# Sample command line:
#   $ ./statistics.rb /dev/shm/floodgate
#
# Author::    Daigo Moriwaki <daigo at debian dot org>
# Copyright:: Copyright (C) 2009-2012 Daigo Moriwaki <daigo at debian dot org>
#
# $Id$
#
#--
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
#++

$:.unshift File.dirname(__FILE__)
require 'csa-filter'
require 'set'

class Monthly
  def initialize
    @games = Hash.new {|hash,key| hash[key] = 0}
    @players = Hash.new {|hash,key| hash[key] = Set.new}
  end

  def add(csa)
    st = csa.start_time
    month = st.strftime("%Y%m")

    @games[month] += 1

    [csa.black_id, csa.white_id].each do |player|
      @players[month].add(player)
    end
  end

  def print
    puts "YYYYMM\t#games\t#players"
    @games.sort {|a,b| a[0] <=> b[0]}.each do |key,value|
      puts "%s\t% 6d\t% 2d" % [key, value, @players[key].size]
    end
  end
end

class Values
  def initialize
    @v = []
  end

  def add(value)
    case value
    when Array 
     @v.concat value
    else
      @v << value
    end
  end

  def print(file)
    total = @v.inject(0){|sum, item| sum+item}
    avg   = 1.0*total/@v.size
    puts "avg: %f sec (size: %d)" % [avg, @v.size]

    File.open(file, "w") do |f|
      @v.each {|v| f.puts v}
    end
  end
end

class State
  def initialize
    @hash = Hash.new {|hash,key| hash[key] = 0}
  end

  def add(value)
    if value.nil? || value.empty?
      value = "error"
    end
    @hash[value] += 1
  end

  def print
    puts "status\t#games"
    @hash.sort {|a,b| b[1] <=> a[1]}.each do |key, value|
      puts "%s\t% 6d" % [key, value]
    end
  end
end

$monthly  = Monthly.new
$gametime = Values.new
$movetime = Values.new
$moves    = Values.new
$states   = State.new

def do_file(file)
  $OPT_REPEAT -= 1 if $OPT_REPEAT > 0
  csa = CsaFileReader.new(file, "EUC-JP")

  # Want to see completed games only
  $states.add csa.state
  return unless csa.state == "toryo"

  # 1. Process monthly
  $monthly.add(csa)

  # 2. Process gametime
  duration = (csa.end_time - csa.start_time).to_i
  $gametime.add duration.to_i

  # 3. Process movetime
  values = csa.movetimes
  $movetime.add values

  # 4. Process moves
  $moves.add values.size

rescue => ex
  $stderr.puts "ERROR: %s" % [file]
  throw ex
end

if $0 == __FILE__
  def usage
puts <<-EOF
SYNOPSIS:
    #{$0} [OPTION]... file or dir [...]

DESCRIPTION:
    It calculates game statistics, reading CSA record files.
    If an argument is a directory, it attempts to find files in its
    subdirectories recursively.

    --filter regexp
        only files that are matched with a regexp are processed (default: no filter)

    --repeat n
        at most n files are processed (default: unlimitted)
EOF
    exit 1
  end

  usage if ARGV.empty?

  parser = GetoptLong.new(
             ['--repeat', '-n', GetoptLong::REQUIRED_ARGUMENT],
             ['--filter', GetoptLong::REQUIRED_ARGUMENT],
             ['--h', '-h', GetoptLong::NO_ARGUMENT]
           )
  begin
    parser.each_option do |name, arg|
      eval "$OPT_#{name.sub(/^--/, '').gsub(/-/, '_').upcase} = '#{arg}'"
    end
  rescue
    usage
  end

  if $OPT_H
    usage
  end

  $OPT_REPEAT = $OPT_REPEAT.to_i
  if $OPT_REPEAT == 0
    $OPT_REPEAT = -1
  end

  while (cmd = ARGV.shift)

    if FileTest.directory?(cmd)
      Dir.glob(File.join(cmd, "**", "*.csa")).each do |file|
        break if $OPT_REPEAT == 0
        if $OPT_FILTER.nil? || /#{$OPT_FILTER}/ =~ file
          do_file(file)
        end
      end
    elsif FileTest.file?(cmd)
      break if $OPT_REPEAT == 0
      if $OPT_FILTER.nil? || /#{$OPT_FILTER}/ =~ cmd
        do_file(cmd)
      end
    else
      throw "Unknown file or directory: #{cmd}"
    end

    puts "States"
    puts "------"
    $states.print
    puts
    puts "=== Toryo Games ==="
    puts
    puts "Montly"
    puts "------"
    $monthly.print
    puts
    puts "Play Time"
    puts "---------"
    $gametime.print("gametime.dat")
    puts
    puts "Move Time"
    puts "---------"
    $movetime.print("movetime.dat")
    puts
    puts "Moves"
    puts "-----"
    $moves.print("moves.dat")
  end
end

