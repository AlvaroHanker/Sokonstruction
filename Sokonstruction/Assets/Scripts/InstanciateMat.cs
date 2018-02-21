using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InstanciateMat : MonoBehaviour {

    private Material[] materials;

	// Use this for initialization
	void Start () { 

        if (this.gameObject.tag != "Pasivo") {
            materials = this.gameObject.GetComponent<Renderer>().materials;
            foreach (Material mat in materials)
                Debug.Log(mat.name);
            setColors(this.gameObject.tag, materials[0], materials[1]);
        }
		
	}
	
	// Update is called once per frame
	void Update () {

	}

    private void setColors(string color,Material matout, Material matem) {

        //Valores predeterminados como si tuviera el color negro y vector de offset random
        Color colorFinal = Color.black;
        Color colorEm = Color.white;
        Vector4 offset = new Vector4(Random.Range(0.0f, 1.1f), Random.Range(0.0f, 1.1f),0.0f,0.0f);

        if (color == "Blue") {
            colorFinal = Color.blue;
            colorEm = new Color(0, 1, 0.840f, 1);
        }
        else if (color == "Red") {
            colorFinal = Color.red;
            colorEm = new Color(1, 0.982f, 0.279f, 1);
        }
        else if (color == "Yellow") {
            colorFinal = Color.yellow;
            colorEm = Color.white;
        }

        matout.SetColor("_Albedo", colorFinal);
        matem.SetColor("_Albedo", colorFinal);
        matem.SetColor("_Emmisive", colorEm);
        matem.SetFloat("_EmStrength", 1.0f);
        matem.SetVector("_OffsetVector", offset);
    }

}
