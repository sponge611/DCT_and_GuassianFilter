imdata = double(imread("cat1.png"));
imdata = imdata/255;
height = size(imdata,1);
width = size(imdata,2);
org = imdata;
u = zeros(8,1,8);
U = zeros(8,8,8,8);
U_t = zeros(8,8);
T = zeros(8,8); 
data_t = zeros(8,8);
t = zeros(64,1);
for i = 1:8
    for r = 0:7
        if i==1
            C = 2^0.5/2;
        else
            C = 1;
        end
        u(r+1,1,i) = (2^0.5)*C/(8^0.5)*cos((2*r+1)*(i-1)*pi/16);
    end
end

for i = 1:8
    for j = 1:8
        a = u(:,1,i);
        b = u(:,1,j);
        U(:,:,i,j) = a*b';
    end
end


for rgb = 1:3
    for row = 0:(height/8-1)
        for column = 0:(width/8-1)
            data_t(:,:) = imdata(row*8+1:row*8+8,column*8+1:column*8+8,rgb);
            for i = 1:8
                for j = 1:8
                    U_t(:,:) = U(1:8,1:8,i,j);
                    t = dot(U_t,data_t,2);
                    val = sum(t);
                    T(i,j) = val(1,1);
                end
            end
            data_t(:,:) = zeros(8,8);
            for i = 1:8
                for j = 1:8
                    data_t(:,:) = data_t(:,:) + T(i,j)*U(1:8,1:8,i,j);
                end
            end
            imdata(row*8+1:row*8+8,column*8+1:column*8+8,rgb) = data_t(:,:);
        end
    end
end

subplot(1,2,1), imshow(org);
subplot(1,2,2), imshow(imdata);

imwrite(imdata,"cat1_DCT_88.jpg");

SE = 0;
for rgb = 1:3
    for i = 1:height
        for j = 1:width
            SE = SE + (org(i,j,rgb)*255 - imdata(i,j,rgb)*255)^2;
        end
    end
end
MSE = SE/(height*width*3);
PSNR = 10 * log10(255^2/MSE);
disp("psnr:");
disp(PSNR);
