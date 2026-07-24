#!/usr/bin/env ruby
# frozen_string_literal: true

root = File.expand_path('..', __dir__)
part_titles = {
  '01' => '## 第一部 父の残した部屋',
  '04' => '## 第二部 ひとりでは続かない',
  '06' => '## 第三部 奪還作戦',
  '09' => '## 第四部 なんとかなれ',
  '12' => '## 第五部 帰還と反転'
}

directory = 'novel_chapters'
chapters = Dir.glob(File.join(root, directory, '[0-9][0-9]_*.md')).sort
abort("No chapter files found in #{directory}/") if chapters.empty?

body = chapters.flat_map { |path|
  chapter_number = File.basename(path)[/^\d{2}/]
  [part_titles[chapter_number], File.read(path).rstrip].compact
}.join("\n\n")

output = <<~MARKDOWN.rstrip
  # 小さな鎧さんたちの冒険

  <figure class="book-cover">
  <img src="illustrations/00_british_picturebook_cover.png" alt="小さな鎧さんたちの冒険の表紙" loading="eager">
  </figure>

  #{body}
MARKDOWN

output_path = File.join(root, '小説版_本文.md')
File.write(output_path, output + "\n")
puts "Built #{output_path} from #{chapters.length} chapter file(s)."
