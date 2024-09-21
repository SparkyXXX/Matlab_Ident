function object = create_frequency_function_data_object_from_csv(file, dt)
    data = readmatrix(file);
    input = data(:, 3);
    output = data(:, 4);
    object = idfrd(output, input, dt);
end