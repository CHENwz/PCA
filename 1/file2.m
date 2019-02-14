%获取40个头像的矩阵 10304*40,40张图片表示的向量，每一列为一张图片
all_image = zeros(10304, 40); 

%求40张图片平均值u
u = zeros(10304, 1);
u_image = zeros(112, 92);

for i = 1:40
    file_path = strcat('./train_faces/', num2str(i), '.pgm');
    image = double(imread(file_path));
    u_image = u_image + image;
    for x = 0:91 %91列
        for y = 1:112 %每一列有112个像素
            all_image(x*112+y, i) = image(y, x+1);
        end
    end
end



u_image = u_image/40;



for x = 0:91 %91列
    for y = 1:112 %每一列有112个像素
        u(x*112+y, 1) = u_image(y, x+1);
    end
end


%中心化矩阵，即求差值
D_value = zeros(10304, 40);
for i = 1:40
        D_value(:,i) = all_image(:,i) - u;
end




%协方差矩阵c
c = D_value*D_value';

%k的取值决定准确率,w为特征向量的矩阵，每一列为一个特征脸
k = 50;
[w, n] = eigs(c, k);


%每幅图像的投影，k*40
Y = zeros(k,40);
for i = 1:40
    Y(:,i) = w'* D_value(:,i);
end



dlmwrite('./data/u.txt',u);
dlmwrite('./data/w.txt',w);
dlmwrite('./data/Y.txt',Y);


%{
test = zeros(112, 92);
for i = 1:112
    for j = 1:92
        test(i,j) = D_value(i+(j-1)*112 ,12);
    end
end
imshow(uint8(test));
%}



