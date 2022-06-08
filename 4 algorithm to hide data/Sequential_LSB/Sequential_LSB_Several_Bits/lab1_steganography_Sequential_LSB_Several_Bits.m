clear
close
clc

% Read a text file
file_id = fopen('message.txt','r');
data=textscan(file_id,'%s','delimiter','\n');
fclose(file_id);
text='';
data_string=string(data{:});

% Convert string to array of characters
for i=1:length(data_string)
    text=text+data_string(i)+' ';
end
text=char(text);
disp(length(text)); % 8192

% Read original image
origin_image=imread('cameraman.tif');
[row, col]=size(origin_image);

for bit=1:8
    % Get my required text according to each image size
    mytext=required_text_for_each_image_using_Sequential_LSB_Several_Bits(text, origin_image, bit);
    
    % Hide info
    stego_image=hide_info_using_Sequential_LSB_Several_Bits(mytext, origin_image, bit);
    stego_image=uint8(stego_image);
    
    % Show Images
    subplot(2,4,bit)
    imshow(stego_image);title(['Sequential LSB Several ',num2str(bit),' Bits']);
    
    % Finding value of Peak Signal to Noise Ratio
    % Note: psnr() parameters must be uint8
    PSNR=psnr(stego_image, origin_image);
    xlabel(['PSNR=',num2str(PSNR)]);
    
    % Extract info
    info=extract_info_using_Sequential_LSB_Several_Bits(stego_image, bit);
    disp('=====================================================');
    disp(info);
end