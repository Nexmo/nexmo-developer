require 'find'

@dir_path = '../app/views'
@output_file = File.open("css_list.txt", "w")
@output = []
@grid_css = [
    'small-',
    'large-',
    'medium-',
    'small-offset-',
    'medium-offset-',
    'large-offset-',
    'small-centered',
    'medium-centered',
    'large-centered',
    'large-collapse',
    'medium-collapse',
    'small-collapse',
    'large-offset-',
    'small-offset-',
    'medium-offset-',
]
@reveal_css = [
    'reveal-modal',
    'close-reveal-modal',
    'reveal-modal-bg',
]

def find_css(css_array)
    Dir.glob("#{@dir_path}/**/*.html.erb") do |erb_file|
        css_array.each do |css|
            File.open(erb_file).each do |line|
                if line.include?(css)
                    @output << "Line #{$.} in #{erb_file}: #{line}"
                end
            end
            @output
        end
    end
    @output_file.puts @output
end

find_css(@grid_css)
find_css(@reveal_css)
@output_file.close
