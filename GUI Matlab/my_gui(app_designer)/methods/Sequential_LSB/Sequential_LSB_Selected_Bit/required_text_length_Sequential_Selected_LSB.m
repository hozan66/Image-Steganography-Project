function char_num=required_text_length_Sequential_Selected_LSB(matrix)
    % Calculate number of the characters
    [row, col, plane]=size(matrix);
    pixel_num=row*col*plane;
    char_num=fix(pixel_num/8);
    
    % Plus 1 symbols
    char_num=char_num+1;
end