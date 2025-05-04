# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# TEST IMAGE PROCESSORS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Color output function
# Usage: color_log "message" "color"
# Colors: green, orange, blue, red
color_log() {
    local message="$1"
    local color="$2"

    case "$color" in
        green)  echo -e "\033[0;32m$message\033[0m" ;;
        orange) echo -e "\033[0;33m$message\033[0m" ;;
        blue)   echo -e "\033[0;34m$message\033[0m" ;;
        red)    echo -e "\033[0;31m$message\033[0m" ;;
        *)      echo "$message" ;;
    esac
}

# Print newline
newline() {
    echo ""
}

# Print section header
# Usage: section_header "title" "color"
section_header() {
    local title="$1"
    local color="$2"
    local line="=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="

    newline
    color_log "$line" "$color"
    color_log "$title" "$color"
    color_log "$line" "$color"
}

# Print subsection header
# Usage: subsection_header "title" "color"
subsection_header() {
    local title="$1"
    local color="$2"
    local line="=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="

    newline
    color_log "$line" "$color"
    color_log "$title" "$color"
    color_log "$line" "$color"
}

# Test counter
test_counter=0

# Print test message
# Usage: test_message "message"
test_message() {
    local message="$1"
    test_counter=$((test_counter + 1))
    color_log "$test_counter. Testing $message..." "blue"
}

# Calculate percentage
# Usage: calculate_percentage part total
calculate_percentage() {
    local part="$1"
    local total="$2"
    echo $(( (part * 100) / total ))
}

# Calculate compression percentage
# Usage: calculate_compression_percentage original_size compressed_size
calculate_compression_percentage() {
    local original="$1"
    local compressed="$2"
    local compressed_percentage=$(calculate_percentage "$compressed" "$original")
    echo $((100 - compressed_percentage))
}

# Print compression ratio
# Usage: print_compression_ratio original_size compressed_size
print_compression_ratio() {
    local original="$1"
    local compressed="$2"
    local ratio=$(calculate_compression_percentage "$original" "$compressed")
    color_log "(${ratio}%)" "red"
}

# Print test result
# Usage: test_result "message" original_size compressed_size
test_result() {
    local message="$1"
    local original="$2"
    local compressed="$3"

    echo "$message"
    if [ -n "$original" ] && [ -n "$compressed" ]; then
        print_compression_ratio "$original" "$compressed"
    fi
}

# Test image processor
# Usage: test_processor "processor_name" "input_file" "output_file" "command"
test_processor() {
    local processor="$1"
    local input_file="$2"
    local output_file="$3"
    local command="$4"

    test_message "$processor"
    cp "$input_file" "$output_file"
    original_size=$(stat -c%s "$output_file")
    test_result "Original size: $original_size bytes"
    eval "$command"
    compressed_size=$(stat -c%s "$output_file")
    test_result "Compressed size: $compressed_size bytes" "$original_size" "$compressed_size"
}

# Test package version
# Usage: test_version "package_name" "version_command"
test_version() {
    local package="$1"
    local command="$2"

    color_log "Testing $package version:" "blue"
    eval "$command" | head -n 3
    newline
}

# Define script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_DIR="${SCRIPT_DIR}/img_test"

section_header "Testing Image Processors:" "orange"

# Create local directory for tests
mkdir -p "${TEST_DIR}"
cd "${TEST_DIR}"

# Download test images
color_log "Downloading test images..." "blue"
# size: 196684
wget -O test-start-kit.jpg https://raw.githubusercontent.com/the-teacher/rails7-startkit/master/Rails7StartKit/assets/logos/Rails7.StartKit.jpg
# size: 124033
wget -O test-thinking-sphinx.png https://raw.githubusercontent.com/the-teacher/rails7-startkit/master/Rails7StartKit/assets/images/thinking-sphinx.png
# size: 4888813
wget -O test-cat.gif https://media.tenor.com/yLjbMCoTu3UAAAAd/cat-pounce.gif

echo "Original file sizes:"
ls -lh test-*.{jpg,png,gif}

# Test JPEG processors
subsection_header "Testing JPEG processors:" "green"

test_processor "jpeg-recompress" \
              "test-start-kit.jpg" \
              "start-kit.jpg" \
              "jpeg-recompress --strip start-kit.jpg start-kit.jpg"

test_processor "jpegoptim" \
              "test-start-kit.jpg" \
              "start-kit.jpg" \
              "jpegoptim --strip-all start-kit.jpg"

test_processor "jpegtran" \
              "test-start-kit.jpg" \
              "start-kit.jpg" \
              "jpegtran -verbose -optimize -outfile start-kit.jpg start-kit.jpg"

test_processor "jhead" \
              "test-start-kit.jpg" \
              "start-kit.jpg" \
              "jhead -purejpg start-kit.jpg"

# Test PNG processors
subsection_header "Testing PNG processors:" "green"

test_processor "advpng" \
              "test-thinking-sphinx.png" \
              "thinking-sphinx.png" \
              "advpng --recompress --shrink-normal thinking-sphinx.png"

test_processor "oxipng" \
              "test-thinking-sphinx.png" \
              "thinking-sphinx.png" \
              "oxipng -o 3 --strip all thinking-sphinx.png"

test_processor "optipng" \
              "test-thinking-sphinx.png" \
              "thinking-sphinx.png" \
              "optipng thinking-sphinx.png"

test_processor "pngquant" \
              "test-thinking-sphinx.png" \
              "thinking-sphinx.png" \
              "pngquant --speed 4 --verbose --force --output thinking-sphinx.png thinking-sphinx.png"

test_processor "pngcrush" \
              "test-thinking-sphinx.png" \
              "thinking-sphinx.png" \
              "pngcrush thinking-sphinx.png thinking-sphinx.png -ow"

test_processor "pngout" \
              "test-thinking-sphinx.png" \
              "thinking-sphinx.png" \
              "pngout thinking-sphinx.png thinking-sphinx.png -s2 -y"

# Test GIF processor
subsection_header "Testing GIF processor:" "green"

test_processor "gifsicle" \
              "test-cat.gif" \
              "cat.gif" \
              "gifsicle -I cat.gif"

# Test ImageMagick
subsection_header "Testing ImageMagick:" "green"

test_processor "ImageMagick convert" \
              "test-start-kit.jpg" \
              "start-kit.jpg" \
              "convert start-kit.jpg -strip -quality 85 start-kit.jpg"

# Final results
section_header "Final Results:" "orange"
ls -lh "${TEST_DIR}"

# Cleanup
color_log "Cleaning up..." "blue"
rm -rf "${TEST_DIR}"/*

# Return to original directory
cd "${SCRIPT_DIR}"

echo "Testing completed. All temporary files have been removed."

# Print versions of all installed image processors
section_header "Installed Image Processors Versions:" "orange"

subsection_header "JPEG Processors:" "green"
test_version "jpeg-recompress" "jpeg-recompress --version"
test_version "jpegoptim" "jpegoptim --version"
test_version "jpegtran" "jpegtran --version"
test_version "jhead" "jhead -V"

subsection_header "PNG Processors:" "green"
test_version "advpng" "advpng --version"
test_version "oxipng" "oxipng --version"
test_version "optipng" "optipng --version"
test_version "pngquant" "pngquant --version"
test_version "pngcrush" "pngcrush --version"
test_version "pngout" "pngout --version"

subsection_header "GIF Processor:" "green"
test_version "gifsicle" "gifsicle --version"

subsection_header "ImageMagick:" "green"
test_version "ImageMagick" "magick --version"
