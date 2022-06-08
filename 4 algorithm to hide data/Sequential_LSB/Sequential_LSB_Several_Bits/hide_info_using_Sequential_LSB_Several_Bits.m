function stego_matrix=hide_info_using_Sequential_LSB_Several_Bits(text, matrix, bit)
    % Convert string to binary_text
    binary_text=dec2bin(text,8)';
    binary_text=binary_text(:)';

    [row, col]=size(matrix);
    stego_matrix=zeros(row, col);
    index=1;

    % Hiding Sequential_LSB_Several_Bits into the matrix Sequentially
    for i=1:row
        for j=1:col
            binary_pixel=dec2bin(matrix(i,j),8);
            for k=bit:-1:1
                binary_pixel(end+1-k)=binary_text(index);
                index=index+1;
            end
            stego_matrix(i,j)=bin2dec(binary_pixel);
        end
    end
end