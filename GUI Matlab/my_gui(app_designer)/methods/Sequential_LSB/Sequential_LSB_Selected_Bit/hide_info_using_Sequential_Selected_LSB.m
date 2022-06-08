function stego_matrix=hide_info_using_Sequential_Selected_LSB(text, matrix, bit)
% Message ends with ÿ sign
text(end+1)='ÿ';
% Convert string to binary_text
binary_text=dec2bin(text,8)';
binary_text=binary_text(:)';

[row, col, plane]=size(matrix);
stego_matrix=zeros(row, col, plane);
index=1;

% Hiding Sequential_LSB_Selected_Bit into the matrix Sequentially
for p=1:plane
    for i=1:row
        for j=1:col
            if (index<=length(text)*8)
                binary_pixel=dec2bin(matrix(i,j,p),8);
                binary_pixel(end+1-bit)=binary_text(index);
                index=index+1;
                stego_matrix(i,j,p)=bin2dec(binary_pixel);
            else
                stego_matrix(i,j,p)=matrix(i,j,p);
            end
        end
    end
end
