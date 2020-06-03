package main

import (
    "github.com/gin-gonic/gin"
    "log"
)

func main() {

    r := gin.Default()
    log.Println("test webapp...")

    r.GET("/", func(c *gin.Context) {
        c.String(200, "We got one Gin app interface 李鑫!")
    })

    r.Run("0.0.0.0:9999")
}
