APP = example

OUTDIR = out
SRCDIR = src
INCDIR = inc
OBJDIR = obj

SERVER_FILES = server
CLIENT_FILES = client

SERVER_OBJECTS = $(addprefix $(OBJDIR)/,$(addsuffix .o, $(SERVER_FILES)))
CLIENT_OBJECTS = $(addprefix $(OBJDIR)/,$(addsuffix .o, $(CLIENT_FILES)))


VPATH = .: ./$(SRCDIR) ./$(INCDIR)

CFLAGS = -Wall -Wfloat-equal -Wundef -Wshadow -Wpointer-arith -Wcast-align  \
		-Waggregate-return -Wcast-qual -Wswitch-default -Wswitch-enum -Wconversion -O\
		-I $(INCDIR) 
LDFLAGS = -pthread -Xlinker -Map=$(OUTDIR)/$(APP).map
CC = gcc
RM = rm
MD = mkdir

.PHONY: all
all: MDOBJ $(OUTDIR)/server $(OUTDIR)/client

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(CC) -c $(CFLAGS) $< -o $@

$(OUTDIR)/server: $(SERVER_OBJECTS)
	$(CC) -o $@ $^ $(LDFLAGS)

$(OUTDIR)/client: $(CLIENT_OBJECTS)
	$(CC) -o $@ $^ $(LDFLAGS)

.PHONY: MDOBJ
MDOBJ:
	@$(MD) -p $(OBJDIR)
	@$(MD) -p $(OUTDIR)

.PHONY: clean
clean: 
	@$(RM) -rf $(OBJDIR)/*.o
	@$(RM) -rf $(OUTDIR)/$(APP)
	@$(RM) -rf $(OUTDIR)/$(APP).map
	@$(RM) -rf *.db


