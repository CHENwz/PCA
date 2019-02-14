%获取280个头像的矩阵 10304*280,280张图片表示的向量，每一列为一张图片
all_image = zeros(10304, 280); 

%求280张图片平均值u
u = zeros(10304, 1);
u_image = zeros(112, 92);

for i = 1:40
    file_path = strcat('./faces/s', num2str(i));
    for j = 1:7
        image = imread(strcat(file_path, '/', strcat(num2str(j), '.pgm'))); 
        image = double(image);
        u_image = u_image + image;
        for x = 0:91 %91列
            for y = 1:112 %每一列有112个像素
                all_image(x*112+y, (i-1)*7+j) = image(y, x+1);
            end
        end
    end
    
    
end



u_image = u_image/280;



for x = 0:91 %91列
    for y = 1:112 %每一列有112个像素
        u(x*112+y, 1) = u_image(y, x+1);
    end
end


%中心化矩阵，即求差值
D_value = zeros(10304, 280);
for i = 1:280
        D_value(:,i) = all_image(:,i) - u;
end




%协方差矩阵c
c = D_value*D_value';

%k的取值决定准确率,w为特征向量的矩阵，每一列为一个特征脸
k = 50;
[w, n] = eigs(c, k);


%每幅图像的投影，k*40
Y = zeros(k,280);
for i = 1:280
    Y(:,i) = w'* D_value(:,i);
end



dlmwrite('./data/u.txt',u);
dlmwrite('./data/w.txt',w);
dlmwrite('./data/Y.txt',Y);





