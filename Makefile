INPUT_FILES=$(wildcard *-sentences.txt)
ADDITIONAL_PASSWORD_FILES=$(wildcard *-passwords.txt)
INTERMEDIATE_FILES=$(patsubst %.txt,%_short.txt,$(INPUT_FILES))
OUTPUT_FILES=$(patsubst %_short.txt,%_short_firstletters_long.txt,$(INTERMEDIATE_FILES)) $(patsubst %_short.txt,%_short_randomletters_long.txt,$(INTERMEDIATE_FILES))  $(patsubst %_short.txt,%_short_secondletters_long.txt,$(INTERMEDIATE_FILES)) 
ENTROPY_FILES=$(patsubst %.txt,%.entropy,$(INPUT_FILES) $(INTERMEDIATE_FILES) $(OUTPUT_FILES) $(ADDITIONAL_PASSWORD_FILES))

all: entropy.txt $(INTERMEDIATE_FILES) $(OUTPUT_FILES)
	cat $<

clean:
	rm -f $(OUTPUT_FILES) $(ENTROPY_FILES) $(INTERMEDIATE_FILES) entropy.txt

.PHONY: all clean

entropy.txt: $(ENTROPY_FILES)
	cat $(sort $^) > $@

%.entropy: %.txt entropy.sh Makefile
	./entropy.sh $< > $@

%_short.txt: %.txt extract-short.py Makefile
	python extract-short.py < $< > $@

%_short_firstletters_long.txt: %_short.txt first-letter-long.py Makefile
	python first-letter-long.py < $< > $@

%_short_randomletters_long.txt: %_short.txt random-letter-long.py Makefile
	python random-letter-long.py < $< > $@

%_short_secondletters_long.txt: %_short.txt second-letter-long.py Makefile
	python random-letter-long.py < $< > $@
