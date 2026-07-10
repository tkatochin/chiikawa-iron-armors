#!/usr/bin/env ruby
# frozen_string_literal: true

root = File.expand_path('..', __dir__)
chapters_dir = File.join(root, 'novel_chapters')
output_path = File.join(root, '小説版_本文.md')

chapters = Dir.glob(File.join(chapters_dir, '[0-9][0-9]_*.md')).sort
abort('No chapter files found in novel_chapters/') if chapters.empty?

body = chapters.map { |path| File.read(path).rstrip }.join("\n\n")

output = <<~MARKDOWN.rstrip
  # ちいかわ アイアンアーマーズ 小説版

  ## 第一部 父の残した部屋

  #{body}
MARKDOWN

File.write(output_path, output + "\n")
puts "Built #{output_path} from #{chapters.length} chapter file(s)."