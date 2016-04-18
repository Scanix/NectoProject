package ch.nectoria.entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.tmx.TmxObject;

class EntityManager {

    public var entityList:Array<Dynamic> = [];

    public function new() {

    }

    public function addEntity(obj:TmxObject){
        HXP.scene.getClass(Entity, entityList);

        switch (obj.name) {
            case 'mrMoustache':
                HXP.scene.add(new NPC(obj));
            case 'Shadow':
                HXP.scene.add(new Enemy(obj));
            default :
                trace("unknow type: " + obj.type);
        }

    }
}
