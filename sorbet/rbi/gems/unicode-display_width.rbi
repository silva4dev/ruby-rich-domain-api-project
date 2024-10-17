# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strict
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/unicode-display_width/all/unicode-display_width.rbi
#
# unicode-display_width-2.6.0

module Unicode
end
class Unicode::DisplayWidth
  def get_config(**kwargs); end
  def initialize(ambiguous: nil, overwrite: nil, emoji: nil); end
  def of(string, **kwargs); end
  def self.decompress_index(index, level); end
  def self.emoji_extra_width_of(string, ambiguous = nil, overwrite = nil, _ = nil); end
  def self.of(string, ambiguous = nil, overwrite = nil, options = nil); end
  def self.width_all_features(string, ambiguous, overwrite, options); end
  def self.width_no_overwrite(string, ambiguous, options = nil); end
end
