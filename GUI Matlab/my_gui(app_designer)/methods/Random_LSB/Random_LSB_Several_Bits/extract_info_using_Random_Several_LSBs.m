function extract_text=extract_info_using_Random_Several_LSBs(stego_matrix, bit, stego_key)
% Extract Random_LSB_Several_Bits from the stego_matrix
[row, col, plane]=size(stego_matrix);
index=1;
flag=1;

% Using stego-key as parameter of random number generator
rng(stego_key); % rng(seed_value)
row_index=randperm(row);
col_index=randperm(col);
extract_binary='';

for p=1:plane
    for i=1:row
        for j=1:col
            binary_pixel=dec2bin(stego_matrix(row_index(i),col_index(j),p),8);
            if(char(bin2dec(binary_pixel))=='ÿ')
                flag=0;
                break;
            else
                for k=bit:-1:1
                    extract_binary(index)=binary_pixel(end+1-k);
                    index=index+1;
                end
            end
        end
        if(flag==0)
            break;
        end
    end
    if(flag==0)
        break;
    end
end

% Extract The Text
extract_text='';
index=1;
% remove 2 symbols of (ÿ) sign
for i=1:8:length(extract_binary)-15
    eight_bit=extract_binary(i:i+7);
    extract_text(index)=char(bin2dec(eight_bit));
    index=index+1;
end
end