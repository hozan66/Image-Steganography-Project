function extract_text=extract_info_using_Sequential_LSB_Selected_Bit(stego_matrix, bit)
    % Extract Sequential_LSB_Selected_Bit from the stego_matrix
    [row, col]=size(stego_matrix);
    index=1;

    extract_binary='';
    for i=1:row
        for j=1:col
            binary_pixel=dec2bin(stego_matrix(i,j),8);
            extract_binary(index)=binary_pixel(end+1-bit);
            index=index+1;
        end
    end

    % Extract The Text
    extract_text='';
    index=1;
    for i=1:8:length(extract_binary)
        eight_bit=extract_binary(i:i+7);
        extract_text(index)=char(bin2dec(eight_bit));
        index=index+1;
    end
end