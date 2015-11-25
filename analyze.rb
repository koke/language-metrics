#!/usr/bin/env ruby -KU

require 'rugged'
require 'linguist'

if ARGV.count != 1
  puts "Usage: #{$0} /path/to/your/repo"
  exit 1
end

begin
  repo = Rugged::Repository.new(ARGV.first)
rescue
  puts "Coulnd't find a git repository at #{ARGV.first}"
  exit 2
end
versions = repo.tags.each_name.sort.grep(/^\d+\.\d+(\.\d+)?$/)

prev_commit = nil
prev_data = nil
results = {}
versions.each do |version|
  tag = repo.tags[version]
  oid = tag.target.oid
  project = Linguist::Repository.incremental(repo, oid, prev_commit, prev_data)
  #puts "Version #{version} (#{oid})"
  #puts project.languages.inspect
  results[version] = project.languages
  prev_commit = oid
  prev_data = project.cache
end

#puts results.inspect
SEP=","
all_languages = results.values.reduce([]) {|sum, r| sum << r.keys }.flatten.uniq
puts "Version" + SEP + "Date" + SEP + all_languages.join(SEP)
results.each do |version, result|
  date = repo.tags[version].target.time.strftime("%Y-%m-%d")
  puts version + SEP + date + SEP + all_languages.map {|l| result[l]}.join(SEP)
end
