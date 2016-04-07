namespace :chord_parser do
  task :generate do
    lib_path = File.join(Rails.root, 'lib')
    `racc -g -o #{lib_path}/chord_parser.rb #{lib_path}/chord_parser.ry.rb`
  end
end
