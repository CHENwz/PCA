w = dlmread('./data/w.txt');
Y = dlmread('./data/Y.txt');
u = dlmread('./data/u.txt');

[row, col] = size(Y);

correct_num = 0;
for i = 1:40
    file_path = strcat('./faces/s', num2str(i));
    for j = 8:10 %3张测试图片
        test_image = zeros(10304, 1);
        image = imread(strcat(file_path, '/', strcat(num2str(j), '.pgm'))); %图片路径
        image = double(image);
        for x = 0:91 %91列
            for y = 1:112 %每一列有112个像素
                test_image(x*112+y, 1) = image(y, x+1);
            end
        end
        %待识别人脸
        test_Y = w'*(test_image - u);
        
        %寻找最接近的人脸
        distance = ones(1,280);
        for x = 1:280
            c = (Y(:,x) - test_Y).^2;
            distance(1, x) = sqrt(sum(c(:)));
        end
        [~, I] = min(distance);
        if floor((I+6)/7) == i
            correct_num = correct_num + 1;
        end
    end
end
fprintf('m=280, K=%d, 正确率为：%0.5f%', row,correct_num/120);

