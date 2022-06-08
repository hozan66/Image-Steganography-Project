function char_num=required_text_length_Sequential_Several_LSBs(matrix, bit)
    % Calculate number of the characters
    [row, col, plane]=size(matrix);
    pixel_num=row*col*plane;
    bit_num=pixel_num*bit;
    char_num=fix(bit_num/8);
    
    % Plus 2 symbols
    char_num=char_num+2;
end