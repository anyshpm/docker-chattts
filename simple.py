import ChatTTS
from IPython.display import Audio
import torchaudio
import torch

chat = ChatTTS.Chat()
chat.load(compile=False) # 设置为True以获得更快速度

texts = ["在这里输入你的文本",]

wavs = chat.infer(texts)

torchaudio.save("output1.wav", torch.from_numpy(wavs[0]), 24000, format='wav')
