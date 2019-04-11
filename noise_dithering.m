imdata = imread("cat2_gray.png");
height = size(imdata,1);
width = size(imdata,2);
for row = 1:height
    for column = 1:width
        noise = randi([0 255]);
        if imdata(row,column) > noise
            imdata(row,column) = 255;
        else
            imdata(row,column) = 0;
        end
    end
end

imshow(imdata);

imwrite(imdata,"noise_dithering.jpg")