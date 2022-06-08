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

% Store all images in the photo cell
path='C:\Users\Lenovo\Documents\MATLAB\Steganography\Images\';
photo_list = dir([path, '*.pgm']);
photo=cell(1,length(photo_list));
for i=1:length(photo_list)
  image_name=[path, photo_list(i).name]; 
  photo{i}=imread(image_name);  % list of images
end

% List of PSNR
PSNR_list=zeros(1, length(photo)*8);
index=1;

for i=1:length(photo)
    % Get my required text according to each image size
    mytext=required_text_for_each_image_using_Sequential_LSB_Selected_Bit(text, photo{i});
    
    figure,
     for bit=1:8
        % Hide info
        stego_image=hide_info_using_Sequential_LSB_Selected_Bit(mytext, photo{i}, bit);
        stego_image=uint8(stego_image);
        
        % Saving stego_image
        saving_path='C:\Users\Lenovo\Documents\MATLAB\Steganography\Sequential_LSB\Sequential_LSB_Selected_Bit\Sequential_LSB_Selected_Bit_Images\';
        imwrite(stego_image, [saving_path, num2str(bit),'th_Bit\NewImageName',num2str(i),'.jpg']);
        
        % Show Images
%         subplot(2,4,bit); 
%         imshow(stego_image); title(['Sequential LSB Selected ',num2str(bit),'th Bit']);
        
        % Finding value of Peak Signal to Noise Ratio
        % Note: psnr() parameters must be uint8
        PSNR=psnr(stego_image, photo{i});
%         xlabel(['PSNR=',num2str(PSNR)]);
        
        % List of PSNR
        PSNR_list(index)=PSNR;
        index=index+1;
    end
end
disp('=====================================================');

% Saving PSNR_list into Excel file
SLSB1=PSNR_list(1:8:length(PSNR_list));
SLSB2=PSNR_list(2:8:length(PSNR_list));
SLSB3=PSNR_list(3:8:length(PSNR_list));
SLSB4=PSNR_list(4:8:length(PSNR_list));
SLSB5=PSNR_list(5:8:length(PSNR_list));
SLSB6=PSNR_list(6:8:length(PSNR_list));
SLSB7=PSNR_list(7:8:length(PSNR_list));
SLSB8=PSNR_list(8:8:length(PSNR_list));
file_name = 'C:\Users\Lenovo\Documents\MATLAB\Steganography\Stego_PSNR.xlsx';
mytable=table(SLSB1',SLSB2',SLSB3',SLSB4',SLSB5',SLSB6',SLSB7',SLSB8','VariableNames',{'Sequential_LSB_Selected_1th_Bit','Sequential_LSB_Selected_2th_Bit','Sequential_LSB_Selected_3th_Bit','Sequential_LSB_Selected_4th_Bit','Sequential_LSB_Selected_5th_Bit','Sequential_LSB_Selected_6th_Bit','Sequential_LSB_Selected_7th_Bit','Sequential_LSB_Selected_8th_Bit'});
writetable(mytable,file_name,'Sheet','Sequential_LSB_Selected_Bit','Range','H1');

disp('Done!');





