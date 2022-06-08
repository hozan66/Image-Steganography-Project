function stego_matrix=hide_info_using_Sequential_Several_LSBs(text, matrix, bit)
% adding the stop sign(ÿ)
text(end+1)='ÿ';
% Convert string to binary_text
binary_text=dec2bin(text,8)';
binary_text=binary_text(:)';

[row, col, plane]=size(matrix);
stego_matrix=zeros(row, col, plane);
index=1;
flag=1;

pixel_num=fix( (length(text)*8)/bit );
remain_bit=mod(length(text)*8,bit);
total_bit=pixel_num*bit+remain_bit;
% Hiding Sequential_LSB_Several_Bits into the matrix Sequentially
for p=1:plane
    for i=1:row
        for j=1:col
            binary_pixel=dec2bin(matrix(i,j,p),8);
            if (index <= pixel_num*bit )
                for k=bit:-1:1
                    binary_pixel(end+1-k)=binary_text(index);
                    index=index+1;
                end
            elseif (index <= total_bit )
                for k=bit:-1:(bit+1)-remain_bit
                    binary_pixel(end+1-k)=binary_text(index);
                    index=index+1;
                end
            elseif (index <= total_bit+7)
                % Embeddin ÿ sign
                binary_pixel='11111111';
                index=index+8;
            else
                flag=0;
            end
            
            if(flag==1)
                stego_matrix(i,j,p)=bin2dec(binary_pixel);
            else
                stego_matrix(i,j,p)=matrix(i,j,p);
            end
            
        end
    end
end
end