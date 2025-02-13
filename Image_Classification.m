image=imread("C:\Users\adity\Documents\MATLAB\Tiger.jpg");
image=im2double(image);
size_image=size(image);

transform_image=reshape(image,[size_image(1)*size_image(2) size_image(3)]);
size_tranformed=size(transform_image);

num_colours=6;

[idx,C]=kmeans(transform_image,num_colours,'MaxIter',50,'start','plus','Replicates',5);

for i=num_colours
    transform_image(idx==i,1)=C(i,1);
    transform_image(idx==i,2)=C(i,2);
    transform_image(idx==i,3)=C(i,3);   
end

compressed_image=reshape(transform_image,[size_image(1) size_image(2) size_image(3)]);

imshow(image);
figure,imshow(compressed_image);