function extract_text=extract_info_using_Sequential_Selected_LSB(stego_matrix, bit)
% Extract Sequential_LSB_Selected_Bit from the stego_matrix
[row, col, plane]=size(stego_matrix);
index=1;
flag=1;
dollar_sign_char='';
extract_binary='';

for p=1:plane
    for i=1:row
        for j=1:col
            binary_pixel=dec2bin(stego_matrix(i,j,p),8);
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
% remove ÿ sign
for i=1:8:length(extract_binary)-7
    eight_bit=extract_binary(i:i+7);
    extract_text(index)=char(bin2dec(eight_bit));
    index=index+1;
end
end