function stego_matrix=hide_info_using_Sequential_LSB_Selected_Bit(text, matrix, bit)
    % Convert string to binary_text
    binary_text=dec2bin(text,8)';
    binary_text=binary_text(:)';
    disp(binary_text);
    disp(matrix);

    [row, col]=size(matrix);
    stego_matrix=zeros(row, col);
    index=1;

    % Hiding Sequential_LSB_Selected_Bit into the matrix Sequentially
    for i=1:row
        for j=1:col
            binary_pixel=dec2bin(matrix(i,j),8);
            disp(binary_pixel);
            disp(class(binary_pixel));
            binary_pixel(end+1-bit)=binary_text(index);
            index=index+1;
            stego_matrix(i,j)=bin2dec(binary_pixel);
        end
    end
end