ARUBA_DIR = 'tmp/aruba'

# helper method for performing file operations in steps
# aruba defaults to using 'tmp/aruba'
def in_aruba_dir(file_dir)
  dir = File.dirname(file_dir)
  working_dir = File.join(ARUBA_DIR, dir)

  Dir.chdir working_dir do
    yield
  end
end
