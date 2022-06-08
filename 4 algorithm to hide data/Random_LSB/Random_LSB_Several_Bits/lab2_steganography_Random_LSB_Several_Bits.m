clear
close
clc

% Note: It takes more time to execute the program if we use Random_LSB

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

% stego_key is seed value
stego_key=1999;
for i=1:length(photo) 
    figure,
     for bit=1:8
         % Get my required text according to each image size
         mytext=required_text_for_each_image_using_Random_LSB_Several_Bits(text, photo{i}, bit);
         
        % Hide info
        stego_image=hide_info_using_Random_LSB_Several_Bits(mytext, photo{i}, bit, stego_key);
        stego_image=uint8(stego_image);
        
        % Saving stego_image
        saving_path='C:\Users\Lenovo\Documents\MATLAB\Steganography\Random_LSB\Random_LSB_Several_Bits\Random_LSB_Several_Bits_Images\';
        imwrite(stego_image, [saving_path, num2str(bit),'_Bits\NewImageName',num2str(i),'.jpg']);
        
        % Show Images
        % subplot(2,4,bit); 
        % imshow(stego_image); title(['Random LSB Several ',num2str(bit),' Bits']);
        
        % Finding value of Peak Signal to Noise Ratio
        % Note: psnr() parameters must be uint8
        PSNR=psnr(stego_image, photo{i});
        % xlabel(['PSNR=',num2str(PSNR)]);
        
        % List of PSNR
        PSNR_list(index)=PSNR;
        index=index+1;
    end
end
disp('=====================================================');

% Saving PSNR_list into Excel file
RLSB1=PSNR_list(1:8:length(PSNR_list));
RLSB2=PSNR_list(2:8:length(PSNR_list));
RLSB3=PSNR_list(3:8:length(PSNR_list));
RLSB4=PSNR_list(4:8:length(PSNR_list));
RLSB5=PSNR_list(5:8:length(PSNR_list));
RLSB6=PSNR_list(6:8:length(PSNR_list));
RLSB7=PSNR_list(7:8:length(PSNR_list));
RLSB8=PSNR_list(8:8:length(PSNR_list));
file_name = 'C:\Users\Lenovo\Documents\MATLAB\Steganography\Stego_PSNR.xlsx';
mytable=table(RLSB1',RLSB2',RLSB3',RLSB4',RLSB5',RLSB6',RLSB7',RLSB8','VariableNames',{'Random_LSB_Several_1Bits','Random_LSB_Several_2Bits','Random_LSB_Several_3Bits','Random_LSB_Several_4Bits','Random_LSB_Several_5Bits','Random_LSB_Several_6Bits','Random_LSB_Several_7Bits','Random_LSB_Several_8Bits'});
writetable(mytable,file_name,'Sheet','Random_LSB_Several_Bits','Range','H1');

disp('Done!');





