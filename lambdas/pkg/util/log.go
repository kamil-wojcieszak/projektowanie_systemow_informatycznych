package util

import (
	"encoding/json"
)

func ToString(value any) string {
	b, err := json.Marshal(value)
	if err != nil {
		return err.Error()
	}
	return string(b)
}
