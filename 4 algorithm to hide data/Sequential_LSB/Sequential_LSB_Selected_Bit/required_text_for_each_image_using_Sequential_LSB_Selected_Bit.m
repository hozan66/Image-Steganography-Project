function mytext=required_text_for_each_image_using_Sequential_LSB_Selected_Bit(text, matrix)
    % Calculate number of the characters
    [row, col]=size(matrix);
    pixel_num=row*col;
    char_num=fix(pixel_num/8);

    % Generate The Text
    mytext='';
    index=1;
    for i=1:char_num
        mytext(i)=text(index);
        index=index+1;

        if (index > length(text))
            index=1;
        end
    end
end