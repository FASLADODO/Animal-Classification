function template_matching (TemplateImageFile, TargetImageFile)
    % Read Template image
    TemplateImage = imread(TemplateImageFile);
    % Read target image
    TargetImage = imread(TargetImageFile);
    %Sharpen both images
    %TemplateImage = imsharpen(TemplateImage);
    %TargetImage = imsharpen(TargetImage);
    %convert Template image to grayscale
    TemplateImage = rgb2gray(TemplateImage);
    % CI = Template image
    [RowCI, ColCI] = size(TemplateImage);
    sprintf('The size of the Template image is %d%d.',RowCI, ColCI)
    %convert target image to grayscale
    TargetImage = rgb2gray(TargetImage);
    % TI = target image
    [RowTI, ColTI] = size(TargetImage);
    sprintf('The size of the target image is %d%d.',RowTI, ColTI)
    % Calculate Normalized Cross Correlation Matrix
    cc = normxcorr2(TemplateImage, TargetImage);
    % Display the Normalized Cross Correlation Matrix
    %imshow(cc), title('Normalized Cross Correlation Matrix')
    % CC = Cross Correlation
    [RowCC, ColCC] = size(cc);
    sprintf('The size of the Normalized Cross Correlation Matrix is %d%d.',RowCC, ColCC)
    % Get the peak correlation value (max_cc) and its position (imax)
    % Note imax is the position in a one column array
    [max_cc, imax] = max(abs(cc(:)));
    sprintf('The highest correlation value is %f.', max_cc)
    [ypeak, xpeak] = ind2sub(size(cc), imax(1));
    sprintf('The row col coords of the best match in the cross corr matrix is %d %d.',ypeak, xpeak)
    BestRow = ypeak - (RowCI - 1);
    BestCol = xpeak - (ColCI - 1);
    sprintf('the row col coords of the best match in orig matrix is %d %d.', BestCol, BestRow)
    figure, imshow(TargetImage);
    % Use imrect to indicate the best match area
    h = imrect(gca, [BestCol BestRow (ColCI - 1) (RowCI - 1)]);
end
