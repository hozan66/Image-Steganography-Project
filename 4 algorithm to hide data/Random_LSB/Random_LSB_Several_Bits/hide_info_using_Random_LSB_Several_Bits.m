function stego_matrix=hide_info_using_Random_LSB_Several_Bits(text, matrix, bit, stego_key)
    % Convert string to binary_text
    binary_text=dec2bin(text,8)';
    binary_text=binary_text(:)';

    [row, col]=size(matrix);
    stego_matrix=zeros(row, col);
    index=1;
    
    % Using stego-key as parameter of random number generator
    rng(stego_key); % rng(seed_value)  
    row_index=randperm(row);
    col_index=randperm(col);

    % Hiding Random_LSB_Several_Bits into the matrix randomly
    for i=1:length(row_index)
        for j=1:length(col_index)
            binary_pixel=dec2bin(matrix(row_index(i),col_index(j)),8);
            for k=bit:-1:1
                binary_pixel(end+1-k)=binary_text(index);
                index=index+1;
            end
            stego_matrix(row_index(i),col_index(j))=bin2dec(binary_pixel);
        end
    end
end