function mytext=required_text_for_each_image_using_Random_LSB_Several_Bits(text, matrix, bit)
    % Calculate number of the characters
    [row, col]=size(matrix);
    pixel_num=row*col;
    bit_num=pixel_num*bit;
    char_num=fix(bit_num/8);

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