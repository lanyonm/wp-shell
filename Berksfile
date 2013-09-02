site :opscode

metadata

group :integration do
  %w{ apache2 apt build-essential git mysql php rsync vim }.each do |cb|
    cookbook cb
  end
  cookbook "minitest-handler"
end
