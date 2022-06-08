function stego_matrix=hide_info_using_Random_Selected_LSB(text, matrix, bit, stego_key)
% adding the stop ÿ sign
text(end+1)='ÿ';

% Convert string to binary_text
binary_text=dec2bin(text,8)';
binary_text=binary_text(:)';

[row, col, plane]=size(matrix);
stego_matrix=zeros(row, col, plane);
index=1;

% Using stego-key as parameter of random number generator
rng(stego_key); % rng(seed_value)
row_index=randperm(row);
col_index=randperm(col);

% Hiding Random_LSB_Selected_Bit into the matrix randomly
for p=1:plane
    for i=1:length(row_index)
        for j=1:length(col_index)
            if (index<=length(text)*8)
                binary_pixel=dec2bin(matrix(row_index(i),col_index(j),p),8);
                binary_pixel(end+1-bit)=binary_text(index);
                index=index+1;
                stego_matrix(row_index(i),col_index(j),p)=bin2dec(binary_pixel);
            else
                stego_matrix(row_index(i),col_index(j),p)=matrix(row_index(i),col_index(j),p);
            end
            
        end
    end
end
end