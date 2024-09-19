namespace :fix do
  desc "Исправление опечаток в коде и в названии файлов"
  task :rename_skil do
    directories = ['app', 'config', 'test']

    def replace_in_file(file, from, to)
      text = File.read(file)
      new_content = text.gsub(from, to)

      if text.include?(from) && !text.include?(to)
        File.open(file, "w") { |f| f.puts new_content }
        puts "=== Обновлены данные в #{file} ==="
      end
    end

    def rename_file(file, from, to)
      if file.include?(from) && !file.include?(to)
        new_file = file.gsub(from, to)
        File.rename(file, new_file)
        puts "=== Имя файла #{file} изменено на #{new_file} ==="
      end
    end

    directories.each do |directory|
      Dir.glob("#{directory}/**/*.rb").each do |file|
        replace_in_file(file, 'Skil', 'Skill')
        replace_in_file(file, 'skil', 'skill')
      end

      Dir.glob("#{directory}/**/*skil*.rb").each do |file|
        rename_file(file, 'skil', 'skill')
      end
    end
  end
end
