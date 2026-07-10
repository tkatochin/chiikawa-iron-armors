#!/usr/bin/env ruby
# frozen_string_literal: true

root = File.expand_path('..', __dir__)
chapters_dir = File.join(root, 'novel_chapters')
output_path = File.join(root, '小説版_本文.md')

chapters = Dir.glob(File.join(chapters_dir, '[0-9][0-9]_*.md')).sort
abort('No chapter files found in novel_chapters/') if chapters.empty?

part_titles = {
  '01' => '## 第一部 父の残した部屋',
  '04' => '## 第二部 ひとりでは続かない'
}

body_sections = chapters.flat_map do |path|
  chapter_number = File.basename(path)[/^\d{2}/]
  [part_titles[chapter_number], File.read(path).rstrip].compact
end

body = body_sections.join("\n\n")

output = <<~MARKDOWN.rstrip
  # ちいかわ アイアンアーマーズ 小説版

  #{body}
MARKDOWN

File.write(output_path, output + "\n")
puts "Built #{output_path} from #{chapters.length} chapter file(s)."