function extract_text=extract_info_using_Random_LSB_Selected_Bit(stego_matrix, bit, stego_key)
    % Extract Random_LSB_Selected_Bit from the stego_matrix
    [row, col]=size(stego_matrix);
    index=1;

    % Using stego-key as parameter of random number generator
    rng(stego_key); % rng(seed_value)  
    row_index=randperm(row);
    col_index=randperm(col);

    extract_binary='';
    for i=1:length(row_index)
        for j=1:length(col_index)
            binary_pixel=dec2bin(stego_matrix(row_index(i),col_index(j)),8);
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