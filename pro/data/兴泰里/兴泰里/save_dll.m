function save_dll(filename, nbins)
x = xlsread(filename, 'C2:G62');
[~, ncol] = size(x);

% 未归一化
m = mean(x);
s = std(x);
v = var(x);
xlswrite(filename, {'均值'}, 'B63:B63');
xlswrite(filename, m, 'C63:G63');
xlswrite(filename, {'标准差'}, 'B64:B64');
xlswrite(filename, s, 'C64:G64');
xlswrite(filename, {'方差'}, 'B65:B65');
xlswrite(filename, v, 'C65:G65');

% 归一化
norm_x = mapminmax(x')';
mn = mean(norm_x);
sn = std(norm_x);
vn = var(norm_x);
xlswrite(filename, {'均值'}, 'B71:B71');
xlswrite(filename, mn, 'C71:G71');
xlswrite(filename, {'标准差'}, 'B72:B72');
xlswrite(filename, sn, 'C72:G72');
xlswrite(filename, {'方差'}, 'B73:B73');
xlswrite(filename, vn, 'C73:G73');

data = [];
for i=1:ncol
    h = hist(x(:, i), nbins);
    data = [data, [mean(h); std(h); var(h)]];
%     row_end = 71 + nbins - 1;
%     xlswrite(filename, m, ['C71:C', num2str(row_end)]);
    hist(x(:, i));
    saveas(gcf, [filename(1:end-5), num2str(i), '.jpg'])
end
xlswrite(filename, data, 'C67:G69')

data = [];
for i=1:ncol
    h = hist(norm_x(:, i), nbins);
    data = [data, [mean(h); std(h); var(h)]];
%     row_end = 71 + nbins - 1;
%     xlswrite(filename, m, ['C71:C', num2str(row_end)]);
    hist(norm_x(:, i));
    saveas(gcf, [filename(1:end-5), num2str(i), 'n.jpg'])
end
xlswrite(filename, data, 'C75:G77')

xlswrite(filename, {'未归一化'}, 'A63:A63');
xlswrite(filename, {'归一化'}, 'A71:A71');