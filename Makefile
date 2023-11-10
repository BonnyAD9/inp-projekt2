TARGET:=main
CFLAGS:=-g -Wall -std=c17 -fsanitize=address -Wno-unused-variable
RFLAGS:=-std=c17 -DNDEBUG -O3
CFILES:=main.c

.PHONY: clean install


debug: $(CFILES)
	$(CC) $(CFLAGS) -o $(TARGET) $(CFILES) $(LDFLAGS)

release: $(CFILES)
	$(CC) $(RFLAGS) -o $(TARGET) $(CFILES) $(LDFLAGS)

install:
	sudo cp -i $(TARGET) /usr/bin/$(TARGET)

uninstall:
	sudo rm -i /usr/bin/$(TARGET)

clean:
	-rm $(TARGET)
