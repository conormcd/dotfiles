require 'formula'

module Homebrew extend self
  def orphans
    installed_formulae.each do |formula|
      puts formula.name unless depended_on.include? formula.name
    end
  end

  private

  def depended_on
    @@depended_on ||= installed_formulae.map do |formula|
      formula.deps.map do |dependency|
        dependency.name.gsub(/^.*\//, '')
      end
    end.flatten.uniq
  end

  def installed_formulae
    Dir[File.join(HOMEBREW_CELLAR, '*')].map do |path|
      Formula.factory File.basename(path)
    end
  end
end

Homebrew.orphans
