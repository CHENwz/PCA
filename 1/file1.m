for i = 1:40
    file_path = strcat('./faces/s', num2str(i));
    all_image = zeros(112, 92);
    for j = 1:7  
        image = imread(strcat(file_path, '/', strcat(num2str(j), '.pgm'))); %图片路径
        image = double(image);
        all_image = all_image + image;
    end
    new_image = all_image/7;
    new_image = uint8(new_image);
    imwrite(new_image, strcat('./train_faces/', num2str(i), '.pgm'));
end

