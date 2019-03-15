# encoding: utf-8

class String
  INTERPOLATE_DELIMETER_LIST = [ '"', "'", "\x02", "\x03", "\x7F", '|', '+', '-' ]
  def interpolate(data = {})
    binding = Kernel.binding

    data.each do |k, v|
      binding.local_variable_set(k, v)
    end

    delemeter = nil
    INTERPOLATE_DELIMETER_LIST.each do |k|
      next if self.include? k
      delemeter = k
      break
    end
    raise ArgumentError, "String contains all the reserved characters" unless delemeter
    e = s = delemeter
    string = "%Q#{s}" + self + "#{e}"
    binding.eval string
  end
    
  JSON_ESCAPE_MAP = {
    '\\'    => '\\\\',
    '</'    => '<\/',
    "\r\n"  => '\n',
    "\n"    => '\n',
    "\r"    => '\n',
    '"'     => '\\"' }

  def escape_json
    self.gsub(/(\\|<\/|\r\n|[\n\r"])/) { JSON_ESCAPE_MAP[$1] }
  end
end