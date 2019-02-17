# # encoding: utf-8

# Inspec test for recipe go-audit::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  describe group('barito') do
    it { should exist }
  end

  describe user('barito')  do
    it { should exist }
  end
end
