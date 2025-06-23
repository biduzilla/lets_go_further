package configuration

import (
	"log"

	"github.com/joeshaw/envdecode"
)

type Conf struct {
	Server ConfServer
	DB     ConfDB
}

type ConfServer struct {
	Port  int  `env:"SERVER_PORT,required"`
	Debug bool `env:"SERVER_DEBUG,required"`
}

type ConfDB struct {
	DSN string `env:"GREENLIGHT_DB_DSN,required"`
}

func New() *Conf {
	var c Conf
	if err := envdecode.StrictDecode(&c); err != nil {
		log.Fatalf("Failed to decode: %s", err)
	}

	return &c
}

func NewDB() *ConfDB {
	var c ConfDB
	if err := envdecode.StrictDecode(&c); err != nil {
		log.Fatalf("Failed to decode: %s", err)
	}

	return &c
}
