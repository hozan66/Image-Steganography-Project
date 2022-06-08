function extract_text=extract_info_using_Random_Selected_LSB(stego_matrix, bit, stego_key)
% Extract Random_LSB_Selected_Bit from the stego_matrix
[row, col, plane]=size(stego_matrix);
index=1;
flag=1;
% Using stego-key as parameter of random number generator
rng(stego_key); % rng(seed_value)
row_index=randperm(row);
col_index=randperm(col);

dollar_sign_char='';
extract_binary='';

for p=1:plane
    for i=1:length(row_index)
        for j=1:length(col_index)
            binary_pixel=dec2bin(stego_matrix(row_index(i),col_index(j),p),8);
            dollar_sign_char(index)=binary_pixel(end+1-bit);
            if (mod(index,8)==0)
                if(char(bin2dec(dollar_sign_char))=='ÿ')
                    flag=0;
                    break;
                end
                dollar_sign_char='';
            end
            extract_binary(index)=binary_pixel(end+1-bit);
            index=index+1;
        end
        if (flag==0)
            break;
        end
    end
    if (flag==0)
        break;
    end
end

% Extract The Text
extract_text='';
index=1;
% remove ÿ sign
for i=1:8:length(extract_binary)-7
    eight_bit=extract_binary(i:i+7);
    extract_text(index)=char(bin2dec(eight_bit));
    index=index+1;
end
end