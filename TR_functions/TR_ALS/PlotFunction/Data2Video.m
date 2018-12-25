function [] =Data2Video(Data, VideoName)
    V = VideoWriter(VideoName);
    open(V);
    minimum = min(T2V(Data));
    maxmium = max(T2V(Data));
    diff = maxmium-minimum;
    for i = 1 : 1: size(Data,4)
        writeVideo(V, im2frame( (Data(:,:,:,i)-minimum)/diff));
    end
    close(V);
end