require 'formula'

if ARGV.length != 1
  onoe "Usage: brew which-package <file>"
  exit 1
end

# Get the full path to the file
file = ARGV.shift
unless File.exist? file
  onoe "#{file} does not exist"
  exit 1
end
while File.symlink? file
  resolved = File.readlink(file)
  unless resolved =~ /^\//
    resolved = File.expand_path(resolved, File.dirname(file))
  end
  unless File.exist? resolved
    onoe "#{file} ponts to #{resolved} which does not exist"
    exit 1
  end
  file = resolved
end

# Make sure it's in the cellar
unless file =~ /^#{HOMEBREW_CELLAR}/
  onoe "#{file} does not appear to be installed by Homebrew"
  exit 1
end

# Find the formula
puts Formula.factory file.sub(/^#{HOMEBREW_CELLAR}\//, '').sub(/\/.*/, '')
